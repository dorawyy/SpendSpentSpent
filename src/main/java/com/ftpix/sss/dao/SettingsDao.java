package com.ftpix.sss.dao;

import com.ftpix.sss.dsl.Tables;
import com.ftpix.sss.dsl.tables.records.SettingsRecord;
import com.ftpix.sss.listeners.DaoListener;
import com.ftpix.sss.models.Settings;
import org.jooq.Condition;
import org.jooq.DSLContext;
import org.jooq.impl.TableImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

import static com.ftpix.sss.dsl.Tables.*;

@Component("settingsDaoJooq")
public class SettingsDao implements Dao<SettingsRecord, Settings> {
    private final DSLContext dslContext;
    private final List<DaoListener<Settings>> listeners = new ArrayList<>();

    @Autowired
    public SettingsDao(DSLContext dslContext) {
        this.dslContext = dslContext;
    }

    public List<Settings> getWhere() {
        return dslContext.select().from(SETTINGS)
                .fetch(r -> r.into(Settings.class));
    }

    public Settings createOrUpdate(Settings settings) {
        Settings dbSettings = queryForId(settings.getName());
        if (dbSettings == null) {
            insert(settings);
        } else {
            update(settings);
        }

        return settings;
    }

    public Settings queryForId(String name) {
        return getOneWhere(SETTINGS.NAME.eq(name)).orElse(null);
    }

    @Override
    public DSLContext getDsl() {
        return dslContext;
    }

    @Override
    public void addListener(DaoListener<Settings> listener) {
        listeners.add(listener);
    }

    @Override
    public List<DaoListener<Settings>> getListeners() {
        return listeners;
    }

    @Override
    public TableImpl<SettingsRecord> getTable() {
        return SETTINGS;
    }

    @Override
    public Settings fromRecord(SettingsRecord r) {
        Settings s = new Settings();
        s.setName(r.getName());
        s.setValue(r.getValue());
        s.setSecret(r.getSecret() != null && r.getSecret().equals((byte) 1));
        return s;
    }

    @Override
    public SettingsRecord toRecord(Settings o) {
        SettingsRecord r = new SettingsRecord();
        r.setName(o.getName());
        r.setSecret((byte) (o.isSecret() ? 1 : 0));
        r.setValue(o.getValue());
        return r;
    }
}
